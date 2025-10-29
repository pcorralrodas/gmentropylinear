# gmentropylinear

**Generalized Maximum Entropy Estimation for Linear Models in Stata**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Stata](https://img.shields.io/badge/Stata-Compatible-blue)](#)
[![DOI](https://img.shields.io/badge/DOI-10.1177%2F1536867X1701700113-blue)](http://crossmark.crossref.org/dialog/?doi=10.1177%2F1536867X1701700113&domain=pdf&date_stamp=2017-03-01)

`gmentropylinear` implements the **Generalized Maximum Entropy (GME)** estimator for linear models in **Stata**, as described in:

> Corral, Paul; Kuehn, Daniel; and Jabir, Ermengarde (2017). *Generalized maximum entropy estimation of linear models.* The Stata Journal, 17(1), 240–249.

The GME approach provides a **distribution-free**, **robust**, and **information-theoretic** alternative to traditional least squares or maximum likelihood estimation. It is especially useful when:
- Sample sizes are small  
- Covariates are highly correlated  
- The researcher prefers minimal distributional assumptions  

---

## 🔍 Overview

The `gmentropylinear` command fits a linear model using the **Generalized Maximum Entropy** principle proposed by Golan, Judge, and Miller (1996).  
Instead of minimizing squared residuals or maximizing a likelihood, the method **maximizes entropy** subject to the data’s information constraints—yielding the *most non-committal* solution consistent with the evidence.

### Advantages
- No distributional assumptions on residuals  
- Robust under multicollinearity  
- Works well with small samples  
- Provides both coefficient and error distributions  
- Generates entropy-based diagnostics and pseudo-R²  

---

## ⚙️ Installation

From within Stata:

```stata
github install pcorralrodas/gmentropylinear
```

Or manually clone the repository and place the files in your Stata `PERSONAL` or `PLUS` directory.

---

## 🧩 Syntax

```stata
gmentropylinear depvar [indepvars] [if] [in], support(matrix)
    [sigmavalue(#) endpoint(#) lambda(string)
     wmat(string) residual(string)
     nosigma nocons]
```

### Required
- **support(matrix)** – Matrix defining the support space for β coefficients (must be K×M).

### Optional
| Option | Description |
|--------|--------------|
| `sigmavalue(#)` | Sigma multiplier for the error supports (default = 3) |
| `endpoint(#)` | Number of supports for the error term (default = 3) |
| `nosigma` | Uses fixed endpoints instead of empirical σ |
| `lambda(string)` | Stores estimated λ values |
| `wmat(string)` | Stores estimated w matrix |
| `residual(string)` | Stores residuals |
| `nocons` | Suppresses the constant term |

---

## 📊 Example

```stata
sysuse auto
generate lnprice = ln(price)

matrix support = (-1,-.5,0,.5,1)\(-1,-.5,0,.5,1)\(-5,-2.5,0,2.5,5)\(-5,-2.5,0,2.5,5)

gmentropylinear lnprice mpg weight foreign, ///
    support(support) sigmavalue(3) endpoint(3) ///
    wmat(err) residual(error) lambda(lambda)
```

### Output
```
Generalized Maximum Entropy (Linear)   Number of obs = 74
Degrees of freedom = 3
Model Entropy = 82.3
Pseudo R² = 0.2133
Signal entropy = 0.7867
Noise entropy  = 0.9503
```

---

## 📈 Stored Results

After estimation, results are stored in `e()`:

**Scalars**  
`e(N)` – number of observations  
`e(entropy)` – final model entropy  
`e(pseudoR2)` – pseudo-R²  
`e(sign entropy)` – normalized signal entropy  
`e(noise entropy)` – normalized noise entropy  

**Matrices**  
`e(b)` – coefficient vector  
`e(V)` – variance–covariance matrix  
`e(esupport)` – error support  
`e(betaprobs)` – coefficient parameter probabilities  

---

## 🧠 Methodology Summary

The estimator re-expresses coefficients and errors as expected values over discrete supports:

\[
Y = XZp + Vw
\]

Entropy is maximized subject to the model’s moment constraints, yielding probabilities \( p \) and \( w \) that define the coefficients and residuals.  
Optimization is performed using the **Newton–Raphson** method on the **dual unconstrained formulation**, which is computationally efficient since only \( T \) Lagrange multipliers are estimated.

For further details, see:
- Golan, Judge, and Miller (1996), *Maximum Entropy Econometrics: Robust Estimation with Limited Data*  

---

## 🧾 Citation

If you use this command, please cite:

```bibtex
@article{corral2017gmentropylinear,
  title={Generalized maximum entropy estimation of linear models},
  author={Corral, Paul and Kuehn, Daniel and Jabir, Ermengarde},
  journal={The Stata Journal},
  volume={17},
  number={1},
  pages={240--249},
  year={2017},
  doi={10.1177/1536867X1701700113}
}
```

---

## 🧰 Related Commands

- [`gmentropylogit`](https://ideas.repec.org/c/boc/bocode/s458151.html): Generalized Maximum Entropy for discrete choice models (Corral & Terbish, 2015)  
- [`gme`](https://github.com/amos-golan/gme): Generalized Maximum Entropy library in R (Amos Golan)

---

## 👥 Authors

**Paul Corral** – The World Bank  
**Daniel Kuehn** – Urban Institute  
**Ermengarde Jabir** – American University  

---

## 📜 License

This project is released under the [MIT License](LICENSE).
