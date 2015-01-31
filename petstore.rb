require "sinatra"
require "pry"
require "sqlite3"
db = SQLite3::Database.new "petstore.db"


get "/pets" do

    # grab only the name and phone number of everyone and display them
    all = db.execute("SELECT*FROM pets")

    erb:index, locals:{pets:all}

end


post "/pet" do

  newpet = [params["name"],params["type"]]

  db.execute("INSERT INTO pets (name, type) VALUES (?, ?)", newpet)

  redirect "/pets"

end

get "/pet/:id" do #show pet infomation page

 thispet = db.execute("SELECT * FROM pets WHERE id=(?)", params[:id].to_i)

  erb :rest, locals:{thispet:thispet}
end


put "/pet/:id" do

  db.execute("UPDATE pets SET name=(?) WHERE id=(?)", params["newname"], params[:id].to_i)

  redirect "/pets"

end

delete "/pet/:id" do

  db.execute("DELETE FROM pets WHERE id=(?)", params[:id].to_i)

  redirect "/pets"
end
