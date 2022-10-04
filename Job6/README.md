# Job 6
> - Author: [Abraham Ukachi](https://github.com/abraham-ukachi) 
> - Subject:[Shell-exe](https://github.com/abraham-ukachi/shell-exe)
> - School: [LaPlateforme\_](https://laplateforme.io)
> - Script: [my_calculator.sh](./my_calculator.sh)



## Description
> Original text in French: 
> Poussons un peu les conditions, pour cela, vous allez créer une minicalculatrice qui \
>  permettra de faire les opérations suivantes : “x + - ÷”. \
> Votre script devra se nommer my_calculator.sh \
> Les chiffres de l’opération seront passés en premier et troisième paramètre et le \
> symbole de l’opération en deuxième position de telle sorte que votre script se lance de \
> la manière suivante : \
> ./my_calculator.sh 2 + 3  

Let’s push the conditions a bit - you need to create a mini calculator that will allow you to do the following operations: “x + - ÷”. 

Your script should be named `my_calculator.sh`  The operation numbers will be passed as the first and third parameter and the operation symbol in the second position so that your script starts as follows: \

**./my_calculator.sh 2 + 3**

## Command line usage

### Division

```sh
./my_calculator.sh 210 / 5
```

### Multiplication

```sh
./my_calculator.sh 10.5 x 4
```
> NOTE: The supported multiplication sign is `x` (not `*`) 

### Addition

```sh
./my_calculator.sh 21 + 21
```

### Subtraction

```sh
./my_calculator.sh 200 - 158
```


## Results
> NOTE: These are some giphy captures

![Giphy Capture 1](./.screenshots/giphy_capture1.gif)



## Issues

| No. | Date | Title | Issue | Status
| --- | ---- | ----- | ----- | ------
| 1 | 2022-01-01T07:12 | **MultiDot** | There's a trailing dot (.), whenever a decimal is used in [multiplication](#Multiplication)  | Not Fixed



## TODOs

- [ ] Fix the [**MultiDot** issue](#Issues)
- [ ] Optimize the [my_calculator.sh](./my_calculator.sh) script
- [ ] Remove unwanted comments

  
