 document.addEventListener('turbo:load', function() {
  let timeout;
  const input = document.getElementById('real_time_input');

  if (!input){
    return 
  }

  input.addEventListener('input', function() {
    clearTimeout(timeout);
  
    timeout = setTimeout(function() {
      const inputValue = input.value;
  
      fetch('/searches', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ content: inputValue })
      })
      .catch(error => {
        console.error('Error updating input:', error);
      });
    }, 150);
  });
});