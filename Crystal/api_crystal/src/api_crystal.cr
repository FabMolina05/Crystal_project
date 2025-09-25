# TODO: Write documentation for `ApiCrystal`
require "kemal"
module ApiCrystal
  VERSION = "0.1.0"
  

  get "/" do
    { message: "Bienvenido a mi API en Crystal 🚀" }.to_json
  end

  Kemal.run
end
