defmodule Shop.RichTextToHtml do
  @moduledoc """
  Converte blocos de Rich Text (Strapi) em HTML seguro e semântico.
  """

  # ===============================
  # Entrada principal
  # ===============================
  def to_html(blocks) when is_list(blocks),
    do: Enum.map_join(blocks, "", &render_block/1)

  # ===============================
  # Renderização de blocos
  # ===============================

  defp render_block(%{"type" => "heading", "level" => level, "children" => children}),
    do: wrap("h#{level}", render_children(children))

  defp render_block(%{"type" => "paragraph", "children" => children, "align" => align}),
    do: ~s(<p style="text-align:#{align};">#{render_children(children)}</p>)

  defp render_block(%{"type" => "paragraph", "children" => children}),
    do: ~s(<p style="text-align:justify;">#{render_children(children)}</p>)

  defp render_block(%{"type" => "list", "format" => format, "children" => items})
       when format in ["ordered", "unordered"] do
    tag = if(format == "ordered", do: "ol", else: "ul")
    wrap(tag, Enum.map_join(items, "", &render_list_item/1))
  end

  defp render_block(%{"type" => "quote", "children" => children}),
    do: wrap("blockquote", render_children(children))

  defp render_block(%{"type" => "divider"}), do: "<hr />"

  defp render_block(%{"type" => "code", "children" => children}),
    do: "<pre><code>#{render_children(children)}</code></pre>"

  defp render_block(%{"type" => "image", "image" => %{"url" => url} = image}) do
    alt = image["alternativeText"] || ""
    caption = image["caption"]

    img = ~s(<img src="#{url}" alt="#{alt}" />)
    if caption in [nil, ""], do: img, else: "<figure>#{img}<figcaption>#{caption}</figcaption></figure>"
  end

  defp render_block(%{"type" => "embed", "url" => url}),
    do: ~s(<div class="embed"><iframe src="#{url}" frameborder="0" allowfullscreen></iframe></div>)

  defp render_block(_), do: ""

  # ===============================
  # Renderização de filhos
  # ===============================

  defp render_list_item(%{"type" => "list-item", "children" => children}),
    do: wrap("li", render_children(children))

  defp render_children(children) when is_list(children),
    do: Enum.map_join(children, "", &render_child/1)

  # ===============================
  # Renderização de nós de texto
  # ===============================

  defp render_child(%{"type" => "text", "text" => text} = node) do
    Enum.reduce(
      [
        {"bold", "strong"},
        {"italic", "em"},
        {"underline", "u"},
        {"strikethrough", "s"},
        {"code", "code"}
      ],
      text,
      fn {style, tag}, acc ->
        if Map.get(node, style), do: wrap(tag, acc), else: acc
      end
    )
  end

  defp render_child(%{"type" => "link", "url" => url, "children" => children}),
    do: ~s(<a href="#{url}" target="_blank" rel="noopener noreferrer">#{render_children(children)}</a>)

  defp render_child(%{"type" => type} = node) when type in ["list", "paragraph", "heading"],
    do: render_block(node)

  defp render_child(_), do: ""

  # ===============================
  # Helpers
  # ===============================

  defp wrap(tag, content), do: "<#{tag}>#{content}</#{tag}>"
end
