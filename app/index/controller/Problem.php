<?php
declare (strict_types = 1);

namespace app\index\controller;

use think\facade\Db;
use think\Request;

class Problem
{
    public function index()
    {
        $problems = Db::table('problem')
            ->field("p.id, p.title, c.name catename, p.total_num, p.right_num")
            ->alias('p')
            ->leftJoin('cate c', 'p.cid = c.id')
            ->paginate(20);

        $data = [
            'problems' => $problems,
        ];

        // 用户已登录，查询用户的解题情况
        if (!empty(session('username'))) {
            $problemids = '';
            foreach ($problems as $k=>$v) {
                $problemids .= ',' . $v['id'];
            }
            $problemids = ltrim($problemids, ',');
            $commits = Db::table('commit co')
                ->field('id, pid')
                ->where('status', '=', 1)
                ->where('uid', '=', session('username')['id'])
                ->where('pid', 'in', $problemids)
                ->select();
            $commit_set = array();
            foreach ($commits as $k2=>$v2) {
                $commit_set[$v2['pid']] = 1;
            }
            $data['commit_set'] = $commit_set;
        }
        return view('problem/index', $data);
    }

    public function detail()
    {
        $id = input('get.id');
        if (empty($id)) {
            return redirect('/index.php/index/problem/index');
        }
        $problem = Db::table('problem p')
            ->field('p.title, p.content, p.max_time, p.total_num, p.right_num, u.username, c.name catename')
            ->leftJoin('cate c', 'c.id = p.cid')
            ->leftJoin('user u', 'u.id = p.uid')
            ->where('p.id', '=', $id)
            ->find();
        $cate = Db::table('case c')
            ->field('c.in, c.out')
            ->where('c.pid', '=', $id)
            ->find();
        $comments = Db::table('comment c')
            ->field('u.username, c.content, c.create_time')
            ->leftJoin('user u', 'u.id = c.uid')
            ->where('c.pid', '=', $id)
            ->order('c.create_time', 'desc')
            ->limit(5)
            ->select();
        return view('problem/detail', ['problem' => $problem, 'cate' => $cate, 'comments' => $comments]);
    }

    public function detail_submit(Request $request)
    {
        if ($request->isPost()) {
            $uid = session('username')['id'];
            $pid = input('post.pid');
            $code = input('post.code');
            if (empty($uid) || empty($pid) || empty($code)) {
                return json(array('code' => 1001, 'msg' => '必填信息为空，请正确访问'));
            }
            // 1.以文件的形式保存用户提交的代码
            $filename = 'static/commit/' . md5($uid . $pid . mt_rand(1000, 9999) . time()) . ".php";
            $file = fopen($filename, 'w');
            fwrite($file, $code);

            // 2.插入数据到数据库 status=0
            $commit_id = Db::table('commit')
                ->insertGetId(['uid' => $uid, 'pid' => $pid, 'code_url' => $filename, 'status' => 0, 'create_time' => time(), 'update_time' => time()]);

            // 3.将commit 中的ID存到redis队列中
            $redis = new \Redis();
            $redis->connect('127.0.0.1', 6379);
            $key = 'tp6_online_judge_queue';
            $redis->lPush($key, $commit_id);
            return json(array('code' => 200, 'msg' => '代码上传成功'));
        }
        return view();
    }

    public function comment(Request $request)
    {
        if ($request->isPost()) {
            $uid = input('post.uid');
            $pid = input('post.pid');
            $content = input('post.content');
            Db::table('comment')
                ->save(['uid' => $uid, 'pid' => $pid, 'content' => $content, 'create_time' => time(), 'update_time' => time()]);
            return json(array('code' => 200, 'msg' => '评论提交成功'));
        }
    }

    public function judge_program()
    {
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $key = "tp6_online_judge_queue";
        $commit_id = $redis->rPop($key);
        while (!empty($commit_id)) {
            $commit = Db::table('commit')
                ->where('id', '=', $commit_id)
                ->find();
            $cases = Db::table('case')
                ->where('pid', '=', $commit['pid'])
                ->select();
            $problem = Db::table('problem')
                ->where('id', '=', $commit['pid'])
                ->find();
            $flag = 1;
            foreach ($cases as $case) {
                $in = str_replace(',', ' ', $case['in']);
                $command = "D:\phpstudy_pro\Extensions\php\php7.3.4nts\php.exe E:/PhpstormProjects/github/tpgoj6/public/" . $commit['code_url'] . ' ' . $in;
                $start_time = time();
                $res = exec($command);
                $end_timm = time();
                // 超时
                if ($end_timm - $start_time >= $problem['max_time']) {
                    $flag = 3;
                    Db::table('user')->where('id', '=', $commit['uid'])->inc('total_num', 1)->update();
                    Db::table('commit')->save(['id' => $commit_id, 'status' => 3]);
                    break;
                }
                // 答案错误
                if ($res != $case['out']) {
                    $flag = 2;
                    Db::table('user')->where('id', '=', $commit['uid'])->inc('total_num', 1)->update();
                    Db::table('commit')->save(['id' => $commit_id, 'status' => 2]);
                    break;
                }
            }
            if ($flag == 1) {
                $right_commit = Db::table('commit')
                    ->where('uid', '=', $commit['uid'])
                    ->where('pid', '=', $commit['pid'])
                    ->where('status', '=', 1)
                    ->find();
                if (empty($right_commit)) {
                    Db::table('user')->where('id', '=', $commit['uid'])->inc('total_num', 1)->inc('solve_num', 1)->update();
                } else {
                    Db::table('user')->where('id', '=', $commit['uid'])->inc('total_num', 1)->update();
                }

                Db::table('commit')->save(['id' => $commit_id, 'status' => 1]);
            }
            $commit_id = $redis->rPop($key);
        }
    }
}
