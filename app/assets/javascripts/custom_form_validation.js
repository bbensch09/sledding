console.log("Custom validation JS loaded");

$(document).ready(function(){


    $('#finalize-lesson').click(function(e){
          // age_inputs = $('#lesson_students_attributes_0_age_range').val();
          // age_inputs = $('.age-range-inputs').val();

          age_inputs = []
          $('.age-range-inputs').each(function (index, value) {
            console.log('age-input#' + index + ':' + $(this).val());
            age_integer = parseInt($(this).val());
            age_inputs.push(age_integer);
          });
          min_age = Math.min(...age_inputs)

          console.log("min age of students is "+min_age);
          if (min_age <= 3) {
          // if (1+1==2) {
            e.preventDefault();
            console.log ("prompt user to remove 3 and under kids");
            $('#age-warning').toggleClass('hidden');
            $('#lesson_students_attributes_0_age_range').focus();
          // focus on Time slot field.
          }
      });


});
