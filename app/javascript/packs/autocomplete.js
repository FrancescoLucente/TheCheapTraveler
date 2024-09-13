document.addEventListener("DOMContentLoaded", function() {
    const input = document.getElementById("city_name");
    const suggestions = document.getElementById("suggestions");
  
    input.addEventListener("keyup", function() {
      const query = input.value;
      if (query.length > 2) {  // Inizia a cercare dopo 2 caratteri
        fetch(`/suggest_cities?query=${query}`)
          .then(response => response.json())
          .then(data => {
            suggestions.innerHTML = "";  // Pulisci i vecchi suggerimenti
            data.forEach(city => {
              const suggestion = document.createElement("div");
              suggestion.textContent = city;
              suggestion.addEventListener("click", function() {
                input.value = city;
                suggestions.innerHTML = "";
              });
              suggestions.appendChild(suggestion);
            });
          });
      } else {
        suggestions.innerHTML = "";
      }
    });
  });
  