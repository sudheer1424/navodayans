class UpdateUserRole < ActiveRecord::Migration
  def up
  	execute <<-SQL 
  	update users set role = "user"
  	SQL
  end

  def down
  end
end
