&lt;?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
	<pm:loop name="fields" as="field value"><pm:if expr="value->type != 'hidden'">$@{field}@ = @$_POST['@{field}@'];
	</pm:if></pm:loop>
	$errors = array();
	<pm:loop name="fields" as="field value"><pm:if expr="value->type != 'hidden'"><pm:if expr="value->required">if(!isset($@{field}@) || empty($@{field}@)){
		$errors[] = 'Please enter a @{field}@.';
	}@{"\n"}@</pm:if></pm:if></pm:loop>
	
	if(empty($errors)){
		$@{model}@ = @{model}@::Create();
		<pm:loop name="fields" as="field value"><pm:if expr="value->type != 'hidden'"><pm:if expr="value->type =='calendar'">$@{model}@->set('@{field}@', date('Y-m-d H:i:s', strtotime($@{field}@)));</pm:if><pm:else>$@{model}@->set('@{field}@', $@{field}@);</pm:else>
		</pm:if></pm:loop>$@{model}@->save();
		
		Typeframe::Redirect('@{modelnick}@ added', TYPEF_WEB_DIR . '/admin/@{applicationname}@');
		return;
	} else {
		$pm->setVariable('errors', $errors);
		<pm:loop name="fields" as="field value"><pm:if expr="value->type != 'hidden'">$pm->setVariable('@{field}@', $@{field}@);
		</pm:if></pm:loop>
	}
}

<pm:loop name="fields" as="field value"><pm:if expr="value->type =='model'">$@{value->model}@s = new @{value->model}@();@{"\n"}@$pm->setVariable('@{value->model}@s', $@{value->model}@s);@{"\n"}@</pm:if></pm:loop>

