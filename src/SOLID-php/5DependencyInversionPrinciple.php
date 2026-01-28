<?php

/**
 * Depend on abstractions, not concrete classes
 * 
 */

// bad example
class UserServiceA 
{
    private MysqlUserRepository $repo;

    public function __construct()
    {
        $this->repo = new MysqlUserRepository();
    }
}


// good example
interface UserRepository 
{
    public function save(array $data);
}

class MysqlUserRepository implements UserRepository 
{
    public function save(array $data) {}
}

class UserService 
{
    public function __construct(UserRepository $repo) {}
}