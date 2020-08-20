# AbsintheGen

Scaffold generator for Elixir [Absinthe](https://hexdocs.pm/absinthe/overview.html) projects

## Installation

Available on [hex.pm](https://hex.pm/packages/absinthe_gen). The package can be installed by adding `absinthe_gen` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:absinthe_gen, "~> 0.1.1"}
  ]
end
```

The docs can be found at [https://hexdocs.pm/absinthe_gen](https://hexdocs.pm/absinthe_gen).

## Usage

The scaffold task will generate a schema, a type and a resolver files based on ["Our First Query" tutorial](https://hexdocs.pm/absinthe/our-first-query.html). You can pass in multiple fields, the field types can be found [here](https://hexdocs.pm/absinthe/Absinthe.Type.Scalar.html#module-built-in-scalars).

```
mix absinthe.gen.scaffold my_context my_type my_field:string my_other_field:string

Created:

	lib/absinthe_app_web/schema/my_context_types.ex
	lib/absinthe_app_web/schema.ex
	lib/absinthe_app_web/resolvers/my_type.ex
```

Available options:

- `--path PATH` - specify a subdirectory of `absinthe_app_web` where to create the files.
