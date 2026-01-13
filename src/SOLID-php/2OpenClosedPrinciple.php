<?php

/**
 * Open for extension, closed for modification
 * 
 */

// bad example
class PaymentServiceA 
{
    public function pay(string $method) {
        if ($method == 'paypal') {
            // paypal logic
        } elseif ($method == 'stripe') {
            // stripe logic
        }
    }
}


// good example
interface PaymentGateway 
{
    public function pay(int $amount);
}

class PaypalGateway implements PaymentGateway 
{
    public function pay(int $amount) {}
}

class StripeGateway implements PaymentGateway 
{
    public function pay(int $amount) {}
}

class PaymentServiceB 
{
    public function __construct(PaymentGateway $gateway) {}

    public function pay(int $amount) {
        $this->gateway->pay($amount);
    }
}