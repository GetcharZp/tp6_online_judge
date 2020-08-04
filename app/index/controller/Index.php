<?php
declare (strict_types = 1);

namespace app\index\controller;


use think\db\Where;
use \think\facade\Db;
use think\Request;

class Index
{
    public function index()
    {
        $news = Db::table('news')
            ->alias("n")
            ->leftJoin('user u', 'n.uid = u.id')
            ->field('n.*, u.username')
            ->order('create_time', 'desc')
            ->limit(5)
            ->select();
        $ranks = Db::table('user')
            ->field('username, solve_num')
            ->order('solve_num', 'desc')
            ->order('total_num', 'asc')
            ->limit(5)
            ->select();
        $data = [
            'news' => $news,
            'ranks' => $ranks
        ];
        return view('index/index', $data);
    }

    public function login(Request $request)
    {
        if ($request->isPost()) {
            $user_email = input('post.user_email');
            $password = input('post.password');
            $res = Db::table('user')
                ->where('username|email', "=", $user_email)
                ->where('password', "=", md5($password))
                ->find();
            if (empty($res)) {
                return json(array('code' => 404, 'msg' => '用户名或密码不正确'));
            } else {
                session('username', array('username' => $res['username'], 'id' => $res['id']));
                return json(array('code' => 200, 'msg' => '登录成功'));
            }
        }
        return view("common/login");
    }

    public function exit()
    {
        session('username', null);
        return redirect("/index.php");
    }

    public function register(Request $request)
    {
        if ($request->isPost()) {
            $op = input('post.op');
            $email = input('post.email');
            if ($op == 'get_code') {
                $temp_email = Db::table('user')->where('email', '=', $email)->find();
                if (!empty($temp_email)) {
                    return json(array('code' => 1004, 'msg' => '该邮箱已被注册！'));
                }
                $code = mt_rand(100000, 999999);
                session('code', $code);
                send_email($email, 'GetcharZp 在线练习系统验证码', '验证码为：<b>'.$code.'</b>');
                return json(array('code' => 200, 'msg' => '发送成功，请在邮件中查收'));
            } elseif ($op == 'register_submit') {
                $code = input('post.code');
                $username = input('post.username');
                $password = input('post.password');
                if ($code != session('code')) {
                    return json(array('code' => 1001, 'msg' => '验证码不正确，请重新获取'));
                }
                $temp_user = Db::table('user')->where('username', '=', $username)->find();
                if (!empty($temp_user)) {
                    return json(array('code' => 1003, 'msg' => '该用户名已存在，请重试'));
                }
                $user = array(
                    'username' => $username,
                    'password' => md5($password),
                    'email' => $email,
                    'create_time' => time(),
                    'update_time' => time()
                );
                $user_id = Db::name('user')->insertGetId($user);
                if (!empty($user_id)) {
                    session('username', array('username' => $username, 'id' => $user_id));
                    return json(array('code' => 200, 'msg' => '注册成功'));
                } else {
                    return json(array('code' => 1002, 'msg' => '注册失败，请重试'));
                }
            }
        }
        return view("common/register");
    }
}
