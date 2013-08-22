class ChangeMistakenFieldTypeInNotifications < ActiveRecord::Migration
  def up
    connection.execute(%q{
      alter table notifications
      alter column responsible_party_object_id
      type integer using cast(responsible_party_object_id as integer)
    })
  end

  def down

  end
end
