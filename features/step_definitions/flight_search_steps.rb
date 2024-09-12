Given("I am on the home page") do
  visit root_path
end

When("I fill in {string} with {string}") do |field, value|
  fill_in field, with: value
end

When("I select the departure date {string}") do |date|
  fill_in "Departure date", with: date
end

When("I check the {string} checkbox") do |checkbox|
  check checkbox
end

When("I press {string}") do |button|
  click_button button
end

Then("I should see only direct flights with price equal or below {int} in the results") do |max_price|
  # Controlla se esiste una tabella prima di iterare sulle righe
  if page.has_no_css?('table')
    expect(page).to have_content("No flights found") # Verifica che venga mostrato un messaggio quando non ci sono voli
  else
    within('table') do
      rows = all('tr').drop(1) # Ignora la prima riga degli header

      rows.each do |row|
        # Verifica che il volo sia diretto
        expect(row).to have_content("Yes") # Assumi che "Yes" indichi un volo diretto

        # Estrai il prezzo del volo dalla colonna dei prezzi
        price = row.all('td')[6].text.to_f # Supponendo che il prezzo sia nella 7a colonna
        expect(price).to be <= max_price
      end
    end
  end
end

When('I click on the {string}') do |header|
  click_link header
end


Then("the results should be sorted by {string} in ascending order") do |sort_criteria|
  column_index = case sort_criteria
                 when "price" then 6 
                 when "duration" then 5 
                 when "arrival time" then 4 
                 else raise "Unknown sort criteria: #{sort_criteria}"
                 end

  rows = all("table tbody tr")

  if rows.empty?
    puts "No flights found." # Messaggio di debug o gestisci con un'eccezione o altro
    expect(page).to have_content("No flights found") # Puoi verificare che appaia un messaggio per mancanza di risultati
  else
    # Solo se ci sono risultati, controlla l'ordinamento
    values = rows.map { |row| row.all('td')[column_index].text.to_f }
    expect(values).to eq(values.sort)
  end
end

Then("I should be on the home page") do
  expect(page).to have_current_path(root_path)
end
Then("I should be logged in") do
  expect(page).to have_content("Logout") # Assumi che l'opzione "Logout" appaia dopo il login
end
When("I search for a city called {string}") do |city_name|
  fill_in "city_name", with: city_name
  click_button "Search"
end


Then("I should have {string}") do |text|
  
  expect(page).to have_content(text)
end

