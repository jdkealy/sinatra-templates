App.LoginSignupToggleView = Backbone.View.extend({

});

App.SignUpView = Backbone.View.extend({

});

App.LoginView = Backbone.View.extend({
  template:JST['auth/login'],
  render: function(){
    $(this.el).html(this.template());
    return this;
  }

});

App.SignUpView = Backbone.View.extend({

});

App.Auth = Backbone.View.extend({
  initialize: function(){
    _.bindAll(this,'render');
    this.model.bind('change', this.render);
  },
  render: function(){
    if(this.model.get('code')){
      if(this.model.get('code')==="not_signed_in"){
        var view = new App.LoginView({model:this.model});
        $(this.el).html(view.render().el);

      }
    } else {
      $(this.el).html(this.model.get('email'));
    }
    return this;
  }
});

App.AuthModel = Backbone.Model.extend({
  initialize: function(){

  },
  url:'/auth'
});

App.UserActions = Backbone.View.extend({
  initialize: function(){
    _.bindAll(this,'render');
    this.model.bind('change', this.render);
  },
  render: function(){
    var markup = [];
    if(this.model.get('email')){
      $(this.el).html('Welcome, ' + this.model.get('email') + ' <a href="/sign_out">Sign Out</a>');
    } else {
      $(this.el).html('Welcome, guest  <a href="/sign_in">Sign In</a>');
    }
    return this;
  }
});

$(document).ready(function() {

  var auth_model  = new App.AuthModel();
  var navigation =  new App.UserActions({model:auth_model});
  auth_model.fetch();
  $(".user_roles").html(navigation.el);

});
