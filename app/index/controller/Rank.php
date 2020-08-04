<?php
declare (strict_types = 1);

namespace app\index\controller;

use think\facade\Db;

class Rank
{
    public function index()
    {
        $users = Db::table('user')
            ->order('solve_num', 'desc')
            ->order('total_num', 'asc')
            ->paginate(20);
        return view('rank/index', ['users' => $users]);
    }
}
