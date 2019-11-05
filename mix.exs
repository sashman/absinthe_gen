defmodule AbsintheGen.MixProject do
  use Mix.Project

  def project do
    [
      app: :absinthe_gen,
      version: "0.1.1",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      dialyzer: [plt_add_apps: [:mix]],
      build_embedded: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "AbsintheGen",
      source_url: "https://github.com/sashman/absinthe_gen"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    "Set of tasks to generate boiler plate files for Elixir Absinthe."
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/sashman/absinthe_gen"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
