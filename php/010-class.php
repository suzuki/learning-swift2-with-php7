<?php
interface ExampleInterface
{
    public function foo(): string;
}

class Base
{
    protected $bar = 'bar';
}

class Example extends Base implements ExampleInterface
{
    public function __construct()
    {
        echo 'initialize';
    }

    public function foo(): string
    {
        return $this->bar;
    }
}

$example = new Example();

echo $example->foo();
