$(function() {
  $(document).ready(function(e) {
    $('input[type=submit]').click(function(e) {
      e.preventDefault();
      var board = get_board();
      $.ajax({
        url: '/js',
        type: 'post',
        data: $('form').serialize()
      }).done(function(res, status, xhr) {
        // console.log(res, status, xhr);
        load_board(res);
      });
    });

    $('button.clear').click(function(e) {
      clear_board();
    });

    $('button.add').click(function(e) {
      load_board($('textarea.sample').val());
    });
  });
});

function clear_board() {
  $('.board input').each(function(key, input) {
    $(input).val('');
  });
}

function get_board() {
  var board = [];
  $('.board input').each(function(key, input) {
    board.push($(input).val());
  });
  return board;
}

function load_board(board) {
  $('.board input').each(function(key, input) {
    var val = (board[key] == 0) ? '' : board[key];
    $(input).val(val);
  });
}

function loadSample() {
  var sample = ['',9,6,'',4,'','','',1,1,'','','',6,'','','',4,5,'',4,8,1,'',3,9,'','','',7,9,5,'','',4,3,'',3,'','',8,'','','','',4,'',5,'',2,3,'',1,8,'',1,'',6,3,'','',5,9,'',5,9,'',7,'',8,3,'','','',3,5,9,'','','',7];
  load_board(sample);
}
