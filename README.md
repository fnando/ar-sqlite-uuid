# ar-sqlite-uuid

[![Tests](https://github.com/fnando/ar-sqlite-uuid/workflows/ruby-tests/badge.svg)](https://github.com/fnando/ar-sqlite-uuid)
[![Gem](https://img.shields.io/gem/v/ar-sqlite-uuid.svg)](https://rubygems.org/gems/ar-sqlite-uuid)
[![Gem](https://img.shields.io/gem/dt/ar-sqlite-uuid.svg)](https://rubygems.org/gems/ar-sqlite-uuid)

Override migration methods to support UUID/ULID columns without having to be
explicit about it.

## Installation

```console
$ gem install ar-sqlite-uuid
```

Or add the following line to your project's Gemfile:

```console
$ bundle add ar-sqlite-uuid
```

Also, make sure the extension is loaded. I recommend using
[sqlpkg](https://github.com/nalgeon/sqlpkg-cli). Then you can install the
extension you want to use:

```console
$ sqlpkg install asg017/ulid
$ sqlpkg install sqlite/uuid
```

To load the extension into your sqlite database,

## Usage

On your gemfile, you must specify which extension you want to use by loading
either `ar-sqlite-uuid` or `ar-sqlite-ulid`.

```ruby
source "https://rubygems.org"

# This will use the `sqlite/uuid` extension.
gem "ar-sqlite-uuid"

# This will use the `asg017/ulid` extension.
gem "ar-sqlite-uuid", require: "ar-sqlite-ulid"
```

Alternatively, you can also manually define the function that will be used:

```ruby
# file: config/initialize/active_record.rb

# use ulid
AR::UUID.default_function = "ulid()"

# use ulid with a static prefix
AR::UUID.default_function = "ulid_with_prefix('myapp')"

# use ulid with a dynamic prefix.
# By default it uses the table name, but you can override it by passing a
# `:prefix` key to `t.primary_key` or `create_table`.
AR::UUID.default_function = "ulid_with_prefix('%{prefix}')"

# use uuid
AR::UUID.default_function = "uuid()"
```

When you create a new table, the `id` column will be defined as `TEXT`, using
the defined function as the default value.

```ruby
create_table :users
add_reference :posts, :users

create_table :posts do |t|
  t.belongs_to :user
  # or
  t.references :user
end
```

If you need an integer column, specify the type manually.

```ruby
create_table :users,  do |t|
  t.column :position, :bigserial, null: false
end
```

## Maintainer

- [Nando Vieira](https://github.com/fnando)

## Contributors

- https://github.com/fnando/ar-sqlite-uuid/contributors

## Contributing

For more details about how to contribute, please read
https://github.com/fnando/ar-sqlite-uuid/blob/main/CONTRIBUTING.md.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT). A copy of the license can be
found at https://github.com/fnando/ar-sqlite-uuid/blob/main/LICENSE.md.

## Code of Conduct

Everyone interacting in the ar-sqlite-uuid project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/fnando/ar-sqlite-uuid/blob/main/CODE_OF_CONDUCT.md).
