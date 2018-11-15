module Plex

  module Sortable



    # sort orders
    # title (default)
    # year(:desc)
    # originallyAvailableAt(:desc)
    # addedAt(:desc)
    # lastViewedAt(:desc)
    SORT_ORDER = {
      'title'          => "title",
      'year'           => 'year',
      'release'        => 'originallyAvailableAt',
      'added_at'       => 'addedAt',
      'last_viewed_at' => 'lastViewedAt'
    }
  end

end