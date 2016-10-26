$( document ).ready(function() {

  tortas =[['milanesa',10],['vegetariana',3],['queso',5]]
  torta_status =['CRUDO', 'CASI_LISTO', 'LISTO', 'QUEMADO'];
  count = 0;

  $('.create-oven').on('submit',function(event){
    event.preventDefault();
    $('.create-oven').empty();
    $('.oven').css('visibility', 'visible');
    $('.create-torta').css('visibility', 'visible');
    oven = new Oven();
  });

  $('.create-torta').on('submit',function(event){
    event.preventDefault();
    var type = $('input[name=type]').val();
    var time = parseInt($('input[name=time]').val());

    torta_base = validate_torta(type);

    if (torta_base){
      torta = createTorta(type,time);   
    }else {
      console.log('No existe ese tipo de torta');
    }

    if (torta) {   
      $('#timer').html(torta.time);
      $('#timer').append('<p>'+ torta.status +'</p>');
      $("#timer").addClass('CRUDO');
      setTimeout(oven.bakeTorta,1000,torta);
    }
    
  });

});

// Class Torta
function Torta(type, time){
  this.type = type;
  this.time = time;
  this.status = torta_status[0];
};

createTorta = function(type,time){
  this.type = type;
  this.time = time;
  return new Torta(this.type, this.time);
};
 
validate_torta = function(type){
  this.type = type;
  valid = false;

  tortas.forEach( function(element){
    if (element[0] == this.type){ 
      valid = element;
    }
  });
  return valid;
};

// Class Oven
function Oven(){ 
  this.bakeTorta = function(torta){
    if (torta.time <= 0){
      $('#history').css('display', 'block');
      $('#horno-title').css('display', 'block');
      $('#history').append('<li>' + torta.type + ' ' + torta.status + '</li>');
      count = 0;
    }else {
      min();        
      setTimeout(oven.bakeTorta,1000,torta);
    } 
  };
};

var min = function(){
  count ++;
  torta.time --;
  get_status();
  $("#timer").removeClass();
  $("#timer").addClass(background);
  $('#timer').html(torta.time);
  $('#timer').append('<p>'+ torta.status +'</p>');
}

var get_status = function(){    
   st = count/parseFloat(torta_base[1]);
    if (st < 0.5) {
      torta.status = torta_status[0];
    } else if (st < 0.8) {
      torta.status = torta_status[1];
    } else if (st == 1.0) {
      torta.status = torta_status[2];
    } else if (st > 1.0) {
      torta.status = torta_status[3];
    }
    background = torta.status;
};