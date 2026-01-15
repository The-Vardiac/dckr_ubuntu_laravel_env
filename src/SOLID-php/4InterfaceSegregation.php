<?php

/**
 * Do not force classes to implement method they don't use
 * 
 * Many small interfaces are better than one big interface
 * 
 */

// bad example
interface Worker 
{
    public function work();
    public function eat();
}

class RobotA implements Worker 
{
    public function work() {}
    public function eat() {} // ??? -> robot
}


// good example
interface Workable 
{
    public function work();
}

interface Eatable
{
    public function eat();
}

class Humans implements Workable, Eatable 
{
    public function work() {}
    public function eat() {}
}

class RobotB implements Workable 
{
    public function work() {}
}