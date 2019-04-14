ActiveRecord::Schema.define version: 0 do
  create_table :pages, force: true do |t|
    t.string :uid
    t.string :short_code
    t.string :token
    t.string :after_init_token
  end

  create_table :new_pages, force: true do |t|
    t.string :after_init_token
  end
end
