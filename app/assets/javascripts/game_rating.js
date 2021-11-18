  $('.admin-game-rating').raty({
    readOnly: true,
    score: function() {
      return $(this).attr('data-score');
    },
    path: '/assets/'
  });