module Daemons
  module Rails
    module Helper

    module_function

    def string_blank?(string)
      # The regexp that matches blank strings is expensive. For the case of empty
      # strings we can speed up this method (~3.5x) with an empty? call. The
      # penalty for the rest of strings is marginal.
      string.nil? || string.empty? || /\A[[:space:]]*\z/ === string
    end

    end
  end
end
