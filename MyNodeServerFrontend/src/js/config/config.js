app.config(function($stateProvider, $urlRouterProvider,$locationProvider) {
    $urlRouterProvider.otherwise('/home');
    $stateProvider
    // Here is a list of states
        .state('home',{
            url:'/home',
            templateUrl: 'views/home.html',
            controller: 'HomeCtrl'
        })
        .state('user',{
            url:'/user',
            templateUrl: 'views/usersearch.html',
            controller: 'UserCtrl'
        })
        .state('forum',{
            url:'/forum',
            templateUrl: 'views/forum.html',
            controller: 'ForumCtrl'
        })
        .state('forum.threads',{
            url:'/threads',
            views:{
                'threaddisplay' :{
                    templateUrl: 'partials/threads.html',
                    controller: 'ForumThreadCtrl'
                }

            },
            params: {
                categoryTitle : 'test'
            }
        })
        .state('about',{
            url:'/about',
            templateUrl: 'views/about.html',
            controller: 'AboutCtrl'
        })
        .state('login',{
            url:'/login',
            templateUrl: 'views/login.html',
            controller: 'LoginCtrl'
        });
    $locationProvider.html5Mode(true);
});
