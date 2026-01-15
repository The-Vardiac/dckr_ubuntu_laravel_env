<?php

/** 
 * a class should have only one reason to change 
 * 
 */

// bad example
class UserServiceA 
{
    public function register(array $data) {
        // validate ..
        // save user ..
        // send email ..
    }
}


// good example
class UserValidator 
{
    public function validate(array $data) {}
}

class UserRepository 
{
    public function save(array $data) {}
}

class EmailService
{
    public function sendWelcomeEmail($user) {}
}

class UserServiceB 
{
    public function __construct(
        UserValidator $validator,
        UserRepository $repo,
        EmailService $email
    ) {}

    public function register(array $data)
    {
        $this->validator->validate($data);
        $user = $this->repo->save($data);
        $this->email->sendWelcomeEmail($user);
    }
}