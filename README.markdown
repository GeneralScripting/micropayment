= micropayment

Implemantation of the NVP API provided by micropayment.de.
WIP

== Installation

```
gem install micropayment
```

== Usage

```
require 'micropayment'

Micropayment::Config.api_key = 'api_access_key_from_micropayment_de'

Micropayment::Config.sandbox = 1

Micropayment::Debit.customerList
#=> { "error"=>"0", "count"=>"2", "maxCount"=>"2", "customerIdList"=>["id1", "id2"] }
```

== Contributing to micropayment
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2012 General Scripting UG (haftungsbeschränkt). See LICENSE.txt for further details.

