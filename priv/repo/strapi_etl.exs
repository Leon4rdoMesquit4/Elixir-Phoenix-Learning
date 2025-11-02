defmodule StrapiClient do
  @base_url "http://localhost:1337"

  def get(endpoint) do
    url =
      @base_url <>
        "/api" <>
        endpoint <> "?populate=*"

    Tesla.get(url)
  end

  def get_img(url) do
    Tesla.get(@base_url <> url)
  end
end

IO.inspect(StrapiClient.get("/posts"))
