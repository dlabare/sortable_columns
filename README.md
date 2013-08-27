# SortableColumns

A drop plugin for creating headers to easily sort a listing by any of it's columns.

## Installation

Add this line to your application's Gemfile:

    gem 'sortable_columns'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sortable_columns

## Usage

1) Add the sortable order to your .find, or .paginate

    def index
      @blobs = Blob.all(:order => sortable_order(Blob))
    end

2) Add the header links when listing your blobs.

    <table>
      <tr>
        <th><%= link_to 'Name', sort_params(Blob, :name) %></th>
        <th><%= link_to 'Rank', sort_params(Blob, :rank) %></th>
      </tr>

      <% @blobs.each do |blob| %>
      <tr>
        <td><%= blob.name %></td>
        <td><%= blob.rank %></td>
      </tr>
      <% end %>
    </table>

3) Profit.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Copyright (c) 2009 Daniel LaBare, released under the MIT license
