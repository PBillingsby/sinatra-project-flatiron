<!-- <ul>
<li>Name: <%= pet_obj.name %><input type="checkbox" name="user[pet]" id="<%= pet_obj.id %>" value="<%= 'checked' if pet_obj.user_id == current_user.id %>"></li>
<li>Date Of Birth: <%= pet_obj.dob %></li>
<li>Breed: <%= pet_obj.breed%></li>
<form action="/pets/<%= pet_obj.id %>" method="GET">
  <input type="submit" value="View Pet"><br>
</form> -->


<% @user.pets.each do |pet_obj| %>
  <ul>
  <% pet_obj.attributes.each do |pet_attribute, value| %>
    <% if pet_attribute == "id" || pet_attribute == "user_id"%>
      <%= nil %>
    <% elsif pet_attribute == "weight" && !value.blank? %>
      <li><strong><%= pet_attribute.capitalize %>:</strong> <%= value %>lbs</li>
    <% elsif !value.blank? %>
      <li><strong><%= pet_attribute.capitalize %>:</strong> <%= value %></li> <% #Dynamic pet show %>
    <% end %>
  <% end %>
  <form action="/pets/<%= pet_obj.id %>/edit" method="GET">
    <input type="submit" value="Edit">
  </form>  
  </ul><br><hr><br>
<% end %>


<h1>Update User</h1>
 
<h2>Edits for <%= @user.username %></h2>
 
  <form action="/users/<%= @user.id %>" method="POST">
    <input id="hidden" type="hidden" name="_method" value="patch">
    <label>Edit the User's Name:</label>
    <br>
    <input type="text" name="user[name]" value="<%= @user.username %>">
 
    <br>
    <p>Select an existing pet or create a new one below.</p>
 
 
    <h3>Existing Pets</h3>
    <% @pets.each do |pet| %>
      <input type="checkbox" name="user[pet_ids][]" id="<%= pet.id %>" value="<%= pet.id %>" <%='checked' if @user.pets.include?(pet) %>><%= pet.name %></input><br>
    <% end %>
    <br>
 
    <h3>New Pet</h3>
    <label>Pet Name: </label>
    <br>
    <input type="text" name="pet[name]" id="pet_name"></input>
    <br><br>
 
    <input type="submit" value="Update User">
  </form>


  def list_user_pets # Dynamic pet lister
      html = ""
      current_user.pets.each do |pet_obj|
        pet_obj.attributes.each do |pet_attr, pet_value|
          if pet_attr == "id" || pet_attr == "user_id"
            nil
          elsif pet_value.blank?
            nil
          else
            html << "<li>" + "<strong>#{pet_attr.capitalize}</strong>: #{pet_value}" + "</li>"
          end
        end
        html << "<form action=" + "/pets/#{pet_obj.id}" + " method=" + "GET" + ">"
        html << "<input type=" + "submit" + " value="+ "View pet" + ">"
        html << "</form>"
      end
      html
    end

new_arr.each do |k|
          k.each do |k, v|
            if v == "" || v == nil
              v = "N/A"
            end
          end
        end




  PUT LOGIN IN SESSION
  PUT NEW IN NEW
  