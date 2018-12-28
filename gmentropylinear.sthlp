{smcl}
{* *! version 1.0.0  27nov2014}{...}
{cmd:help gmentropylinear}{right: ({browse "http://www.stata-journal.com/article.html?article=st0473":SJ17-1: st0473})}
{hline}

{title:Title}

{p2colset 5 24 26 2}{...}
{p2col :{cmd:gmentropylinear} {hline 2}}Generalized maximum entropy linear model{p_end}
{p2colreset}{...}


{title:Syntax}

{p 8 23 2}
{opt gmentropylinear} {depvar} [{indepvars}] {ifin}{cmd:,}
{opt sup:port(matrix)}
[{opt sigma:value(#)}
{opt end:point(#)}
{opt lam:bda(string)}
{opt wmat(string)}
{opt res:idual(string)}
{opt nos:igma}
{opt noc:ons}]


{title:Description}

{pstd}
{cmd:gmentropylinear} fits a linear regression model using the
generalized maximum entropy principle.  {cmd:gmentropylinear} requires the user
to provide a parameter support space for the beta coefficients.  This support
space is of dimension K by M, where K is the number of covariates and M is the
number of supports.

{pstd}
The support space for the error terms is by default set to a dimension of
three and is equally and symmetrically built around zero using the three-sigma
rule.  The command allows the user to specify an alternative error support
space (see options).


{title:Options}

{phang}
{opt support(matrix)} requires the user provide a K by M matrix of parameter
supports for the coefficients.  {cmd:support()} is required.

{phang}
{opt sigmavalue(#)} specifies the value for the sigma rule of the error
support.  The default is {cmd:sigmavalue(3)} and is by default done using the
three-sigma rule (see the {cmd:nosigma} option).

{phang}
{opt endpoint(#)} specifies the number of support space parameters.  The
default is {cmd:endpoint(3)} and should always be odd numbered.

{phang}
{opt lambda(string)} specifies a variable to be created to save the estimated
lambdas.

{phang}
{opt wmat(string)} specifies a variable prefix to be created to save the error
support weights.

{phang}
{opt residual(string)} specifies a variable to be created with the predicted
residuals.

{phang}
{opt nosigma} indicates that the value specified in {cmd:sigmavalue()} is the
actual value wished to be used instead of the empirical sigma.

{phang}
{opt nocons} specifies that estimation be carried out without a constant term.


{title:Example}

{phang}{cmd:. sysuse auto}{p_end}
{phang}{cmd:. generate lnprice=ln(price)}{p_end}
{phang}{cmd:. matrix support=(-1,-.5,0,.5,1)\(-1,-.5,0,.5,1)\(-5,-2.5,0,2.5,5)\(-5,-2.5,0,2.5,5)}{p_end}
{phang}{cmd:. gmentropylinear lnprice mpg weight foreign, sup(support) sigma(3) endpoint(3) wmat(err) residual(error) lambda(lambda)}{p_end}


{title:Stored results}

{pstd}
{cmd:gmentropylinear} stores the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(d_fm)}}model degrees of freedom{p_end}
{synopt:{cmd:e(entropy)}}final entropy for model{p_end}
{synopt:{cmd:e(int_entropy)}}initial entropy{p_end}
{synopt:{cmd:e(pseudoR2)}}pseudo R-squared{p_end}
{synopt:{cmd:e(sign_entropy)}}normalized entropy of the signal{p_end}
{synopt:{cmd:e(noise_entropy)}}normalized entropy of the noise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synoptset 20 tabbed}{...}

{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(esupport)}}error support space specified{p_end}
{synopt:{cmd:e(betaprobs)}}coefficient parameter support space{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{title:Authors}

{pstd}
Paul Corral{break}
The World Bank{break}
Washington, DC{break}
pcorralrodas@worldbank.org{p_end}

{pstd}
Daniel Kuehn{break}
Urban Institute {break}
Washington, DC{break}
dkuehn@urban.org{p_end}

{pstd}
Ermengarde Jabir{break}
American University{break}
Washington, DC


{title:Also see}

{p 4 14 2}Article:  {it:Stata Journal}, volume 17, number 1: {browse "http://www.stata-journal.com/article.html?article=st0473":st0473}{p_end}
