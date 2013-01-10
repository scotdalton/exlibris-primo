# ChainGang Modules
ChainGang modules contain methods that are "chainable", i.e. they return `self`.

## ! vs =
ChainGang methods that take arguments are defined with a trailing `!` and aliased
with a trailing `=`.  At the time of writing, the `=` version can't be chained because
the Ruby virtual machine seems to compile the two methods slightly differently and the
`=` version returns the arguments rather than `self`.  The `=` version is intended to
be used as an `attr_writer`.
