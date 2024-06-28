# frozen_string_literal: true

Pagy::DEFAULT[:items]    = 20

require 'pagy/extras/overflow'

Pagy::DEFAULT[:overflow] = :empty_page

Pagy::DEFAULT.freeze
