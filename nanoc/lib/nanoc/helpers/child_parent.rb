# frozen_string_literal: true

module Nanoc::Helpers
  # @see https://nanoc.ws/doc/reference/helpers/#childparent
  module ChildParent
    def parent_of(item)
      if item.identifier.legacy?
        item.parent
      else
        path_without_last_component = item.identifier.to_s.sub(/[^\/]+$/, '').chop
        @items[path_without_last_component + '.*']
      end
    end

    def children_of(item)
      if item.identifier.legacy?
        item.children
      else
        pattern = if item.identifier.to_s =~ %r{^/index[^/]+$}
                    "/*"
                  else
                    item.identifier.without_ext + '/*'
                  end
        @items.find_all(pattern) - [item]
      end
    end
  end
end
