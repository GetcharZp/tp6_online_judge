<?php
declare (strict_types = 1);

namespace app\index\controller;

use think\facade\Db;

class JudgeStatus
{
    public function index()
    {
        $statuss = Db::table('commit c')
            ->field('u.username, c.pid, p.title, c.status, c.create_time')
            ->leftJoin('problem p', 'p.id = c.pid')
            ->leftJoin('user u', 'u.id = c.uid')
            ->order('c.id', 'desc')
            ->paginate(20);
        return view('judge_status/index', array('statuss' => $statuss));
    }
}
