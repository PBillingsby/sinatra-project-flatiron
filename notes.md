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