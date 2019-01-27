<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="create-user" class="content scaffold-create" role="main">
            <h1>Nouveau user</h1>

            <g:if test="${flash.message}">
                <div class="well">${flash.message}</div>
            </g:if>

            <g:hasErrors bean="${this.user}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${this.user}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>

            <g:form resource="${this.user}" method="POST">
                <fieldset class="form">
                    <div class='form-group fieldcontain'>
                        <label for='lastName'>
                            Nom de famille
                            <span class='required-indicator'>*</span>
                        </label>
                        <input class="form-control" type="text" name="lastName" value="" required="" id="lastName" />
                    </div>
                </fieldset>

                <fieldset class="form">
                    <div class='form-group fieldcontain required'>
                        <label for='firstName'>
                            Prénom
                            <span class='required-indicator'>*</span>
                        </label>
                        <input class="form-control" type="text" name="firstName" value="" required="" id="firstName" />
                    </div>
                </fieldset>

                <fieldset class="form">
                    <div class='form-group fieldcontain'>
                        <label for='tel'>
                            Téléphone
                        </label>
                        <input class="form-control" type="text" name="tel" value="" required="" id="tel" />
                    </div>
                </fieldset>

                <fieldset class="form">
                    <div class='form-group fieldcontain'>
                        <label for='dob'>Anniversaire</label>
                        <input class="form-control" type="hidden" name="dob" id="dob" value="date.struct" />
                        <div class="form-group">
                            <div class="col-xs-2">
                                <select class="form-control" name="dob_day" id="dob_day" aria-labelledby="dob">
                                    <option value="" selected="selected"></option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                    <option value="13">13</option>
                                    <option value="14">14</option>
                                    <option value="15">15</option>
                                    <option value="16">16</option>
                                    <option value="17">17</option>
                                    <option value="18">18</option>
                                    <option value="19">19</option>
                                    <option value="20">20</option>
                                    <option value="21">21</option>
                                    <option value="22">22</option>
                                    <option value="23">23</option>
                                    <option value="24">24</option>
                                    <option value="25">25</option>
                                    <option value="26">26</option>
                                    <option value="27">27</option>
                                    <option value="28">28</option>
                                    <option value="29">29</option>
                                    <option value="30">30</option>
                                    <option value="31">31</option>
                                </select>
                            </div>
                            <div class="col-xs-2">
                                <select class="form-control" name="dob_month" id="dob_month" aria-labelledby="dob">
                                    <option value="" selected="selected"></option>
                                    <option value="1">janvier</option>
                                    <option value="2">février</option>
                                    <option value="3">mars</option>
                                    <option value="4">avril</option>
                                    <option value="5">mai</option>
                                    <option value="6">juin</option>
                                    <option value="7">juillet</option>
                                    <option value="8">août</option>
                                    <option value="9">septembre</option>
                                    <option value="10">octobre</option>
                                    <option value="11">novembre</option>
                                    <option value="12">décembre</option>
                                </select>
                            </div>
                            <div class="col-xs-2">
                                <select class="form-control" name="dob_year" id="dob_year" aria-labelledby="dob">
                                    <option value="" selected="selected"></option>
                                    <option value="2010">2010</option>
                                    <option value="2009">2009</option>
                                    <option value="2008">2008</option>
                                    <option value="2007">2007</option>
                                    <option value="2006">2006</option>
                                    <option value="2005">2005</option>
                                    <option value="2004">2004</option>
                                    <option value="2003">2003</option>
                                    <option value="2002">2002</option>
                                    <option value="2001">2001</option>
                                    <option value="2000">2000</option>
                                    <option value="1999">1999</option>
                                    <option value="1998">1998</option>
                                    <option value="1997">1997</option>
                                    <option value="1996">1996</option>
                                    <option value="1995">1995</option>
                                    <option value="1994">1994</option>
                                    <option value="1993">1993</option>
                                    <option value="1992">1992</option>
                                    <option value="1991">1991</option>
                                    <option value="1990">1990</option>
                                    <option value="1989">1989</option>
                                    <option value="1988">1988</option>
                                    <option value="1987">1987</option>
                                    <option value="1986">1986</option>
                                    <option value="1985">1985</option>
                                    <option value="1984">1984</option>
                                    <option value="1983">1983</option>
                                    <option value="1982">1982</option>
                                    <option value="1981">1981</option>
                                    <option value="1980">1980</option>
                                    <option value="1979">1979</option>
                                    <option value="1978">1978</option>
                                    <option value="1977">1977</option>
                                    <option value="1976">1976</option>
                                    <option value="1975">1975</option>
                                    <option value="1974">1974</option>
                                    <option value="1973">1973</option>
                                    <option value="1972">1972</option>
                                    <option value="1971">1971</option>
                                    <option value="1970">1970</option>
                                    <option value="1969">1969</option>
                                    <option value="1968">1968</option>
                                    <option value="1967">1967</option>
                                    <option value="1966">1966</option>
                                    <option value="1965">1965</option>
                                    <option value="1964">1964</option>
                                    <option value="1963">1963</option>
                                    <option value="1962">1962</option>
                                    <option value="1961">1961</option>
                                    <option value="1960">1960</option>
                                    <option value="1959">1959</option>
                                    <option value="1958">1958</option>
                                    <option value="1957">1957</option>
                                    <option value="1956">1956</option>
                                    <option value="1955">1955</option>
                                    <option value="1954">1954</option>
                                    <option value="1953">1953</option>
                                    <option value="1952">1952</option>
                                    <option value="1951">1951</option>
                                    <option value="1950">1950</option>
                                    <option value="1949">1949</option>
                                    <option value="1948">1948</option>
                                    <option value="1947">1947</option>
                                    <option value="1946">1946</option>
                                    <option value="1945">1945</option>
                                    <option value="1944">1944</option>
                                    <option value="1943">1943</option>
                                    <option value="1942">1942</option>
                                    <option value="1941">1941</option>
                                    <option value="1940">1940</option>
                                    <option value="1939">1939</option>
                                    <option value="1938">1938</option>
                                    <option value="1937">1937</option>
                                    <option value="1936">1936</option>
                                    <option value="1935">1935</option>
                                    <option value="1934">1934</option>
                                    <option value="1933">1933</option>
                                    <option value="1932">1932</option>
                                    <option value="1931">1931</option>
                                    <option value="1930">1930</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </fieldset>

                <hr />

                <fieldset class="form">
                    <div class='form-group fieldcontain required'>
                        <label for='username'>
                            Nom d'utilisateur
                            <span class='required-indicator'>*</span>
                        </label>
                        <input class="form-control" type="text" name="username" value="" required="" id="username" />
                    </div>
                </fieldset>

                <fieldset class="form">
                    <div class='form-group fieldcontain required'>
                        <label for='password'>
                            Mot de passe
                            <span class='required-indicator'>*</span>
                        </label>
                        <input class="form-control" type="text" name="password" value="" required="" id="password" />
                    </div>
                </fieldset>

                <fieldset class="form">
                    <div class='form-group fieldcontain required'>
                        <label for='mail'>
                            Adresse mail
                            <span class='required-indicator'>*</span>
                        </label>
                        <input class="form-control" type="text" name="mail" value="" required="" id="mail" />
                    </div>
                </fieldset>

                <fieldset class="buttons">
                    <g:submitButton name="create" class="save btn btn-success" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
