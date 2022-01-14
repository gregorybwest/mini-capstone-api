require "http"


p HTTP.get("http://localhost:3000/products/3").to_s

p HTTP.get("http://localhost:3000/products").to_s
