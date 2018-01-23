ActiveRecord::Schema.define version: 0 do
  create_table :pages, force: true do |t|
    t.string :uid
    t.string :short_code
    t.string :token
    t.string :type
  end
end
