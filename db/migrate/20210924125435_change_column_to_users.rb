class ChangeColumnToUsers < ActiveRecord::Migration[6.1]
  def up
    # Not Null制約を外す場合　not nullを外したいカラム横にtrueを記載
    change_column_null :users, :uid, true
    change_column_null :users, :provider, true
  end

  def down
    change_column_null :users, :uid, false
    change_column_null :users, :provider, false
  end
end
