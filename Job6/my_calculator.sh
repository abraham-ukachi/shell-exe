#!/bin/zsh

# Job 6
# --------------------------------
# Poussons un peu les conditions, pour cela, vous allez créer une minicalculatrice qui
# permettra de faire les opérations suivantes : “x + - ÷”.
# Votre script devra se nommer my_calculator.sh
# Les chiffres de l’opération seront passés en premier et troisième paramètre et le
# symbole de l’opération en deuxième position de telle sorte que votre script se lance de
# la manière suivante :
# ./my_calculator.sh 2 + 3
# --------------------------------


# Get the operator 
# This should be the second given argument. 
operator=$2
# Set the `result` variable to 0
result=0
# Set the boolean `invalid_operator` variable to 0 (ie. false)
invalid_operator=0


# There are so many ways to do this job.
# But since we are required to use conditions, 
# we are going to use the 'case' conditional statement:
case $operator in;
    '/') result=$(($1 / $3));; # division
    'x') result=$(($1 * $3));; # multiplication
    '+') result=$(($1 + $3));; # addition
    '-') result=$(($1 - $3));; # subtraction
    *) invalid_operator=1;; # anything else should not be accepted :-)
esac

# Other solutions No.1:
# Uncomment the code snippet below, to use the 'if' statement instead.
# if [[ operator='/' ]]; then
#     result=$(($1 / $3))
# elif [[ operator='x' ]]; then
#     result=$(($1 * $3))
# elif [[ operator='+' ]]; then
#     result=$(($1 + $3))
# elif [[ operator='-' ]]; then
#     result=$(($1 - $3))
# else
#     invalid_operator=1
#fi

# If the operator is not valid
if [[ $invalid_operator -eq 1 ]]; then
    # create an error message
    err_msg="Please use a valid operator (/, x, +, or -)"
    # Print out the error message in bold red
    printf "\x1b[1m\x1b[31m%s\x1b[0m\n" $err_msg
else
    # Print out the result in bold white
    printf "\x1b[1m%s\x1b[0m\n" $result
fi

