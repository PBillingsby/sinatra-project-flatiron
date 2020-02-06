<div align="right">
  <% @vaccinations.each do |vacc|%>
    <%vacc.each do |vacc_attr, vacc_value|
      <li><strong><%= vacc_attr.capitalize %>:</strong> <%= vacc_value.presence || "N/A"%></li>
    <%end%>
  <%end%>
</div>