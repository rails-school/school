class RemoveProsperityTables < ActiveRecord::Migration
  def change
    drop_table :prosperity_dashboard_graphs
    drop_table :prosperity_graph_lines
    drop_table :prosperity_graphs
  end
end
