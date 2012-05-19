# micropayment

Implemantation of the NVP API provided by micropayment.de.
If you want to use it in your Rails project please use [micropayment-rails](https://github.com/GeneralScripting/micropayment-rails)


WIP!

## Installation

    gem install micropayment

## Usage

First you need to setup at least your API key:

    Micropayment::Config.api_key = 'xxx'
    # to enter sandbox mode:
    Micropayment::Config.sandbox = 1

Let's try out a test payment using direct debit:

```
# create a customer
customer = Micropayment::Debit.customerCreate(
  :firstName  => 'Jeff',
  :lastName   => 'Winger'
)

# add a bank account to the customer
Micropayment::Debit.bankaccountSet(
  :customerId     => customer.customerId,
  :bankCode       => '10010010',
  :accountNumber  => 'something_valid',
  :accountHolder  => "#{customer.firstName} #{customer.lastName}"
)

# create a session
session = Micropayment::Debit.sessionCreate(
  :customerId => customer.customerId,
  :project    => 'your-project-key',
  :amount     => 10.00,
  :payText    => 'Thank you for ...'
)

Micropayment::Debit.sessionApprove(
  :sessionId  => session["sessionId"]
)
```

```
Micropayment::Debit.customerList
#=> { "error"=>"0", "count"=>"2", "maxCount"=>"2", "customerIdList"=>["id1", "id2"] }
```


## Contributing to micropayment
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 General Scripting UG (haftungsbeschränkt). See LICENSE.txt for further details.

