<div align="right">
  <% @vaccinations.each do |vacc|%>
    <%vacc.each do |vacc_attr, vacc_value|
      <li><strong><%= vacc_attr.capitalize %>:</strong> <%= vacc_value.presence || "N/A"%></li>
    <%end%>
  <%end%>
</div>

<h3>or adopt one below</h3>
<ul>
  <%@list_adoptable_pets.each do |pet|%>
    <%#<%binding.pry%>
    <li><%=pet.name%></li>
  <%end%>
</ul>


<h3>For adoptable pets click <a href="/adoption-page"</h3>
<%@adoptable.each do |pet|%>
  <ul>
  <%pet.attributes.each do |attribute, value|%>
    <li><strong><%= attribute %>:</strong> <%= value.presence || "N/A"%></li>
  </ul>
  <%end%><br>
<% end %>



RE ADD

<% @pet_objs.each do |pet| %>
    <ul>
    <% pet.each do |pet_attribute, attribute_value| %>
      <li><strong><%= pet_attribute.capitalize %>:</strong> <%= attribute_value.presence || "N/A"%></li>
    <% end %>
    </ul>
    <form action="/pets/<%=pet["id"]%>" method="GET">
      <input type="submit" value="View">
    </form><br>
  <%end%>