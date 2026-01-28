<?php

/**
 * Child classes must be usable without breaking the parent's behavior
 * 
 * Child classes must be replaceable for their parent
 * 
 */

// bad example
class BirdA 
{
    public function fly() {}
}

class PenguinA extends BirdA 
{
    public function fly() 
    {
        throw new Exception("I can't fly");
    }
}


// good example
interface BirdB {}

interface FlyingBird extends BirdB 
{
    public function fly();
}

class Eagle implements FlyingBird 
{
    public function fly() {}
}

class Penguin implements BirdB 
{
    // no fly method
}