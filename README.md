#Docker for development with MEAN stack


### Build image:  
```sh
	docker build -t royling/mean-dev -f ./Dockerfile ./
```

### Use image to set up workspace:  
1. Start a one-off container to scaffold app with [_generator-angular-fullstack_](https://github.com/angular-fullstack/generator-angular-fullstack):  
	```sh
	docker run -it --name scaffolding -v $PWD:/workspace royling/mean-dev yo angular-fullstack Hello
	```

	NOTE: `open` grunt task is not supported from a docker, so need to modify the scaffolded `Gruntfile.js` first:
	```js
	grunt.task.run([
	  'clean:server',
	  'env:all',
	  'concurrent:pre',
	  'concurrent:server',
	  'injector',
	  'wiredep:client',
	  'postcss',
	  'express:dev',
	  'wait',
	  //'open',
	  'watch'
	]);
	```

2. Install node modules && bower modules:  
	```sh
	docker run -it --name install_modules -v $PWD:/workspace royling/mean-dev npm install && bower install
	```

3. Start MongoDB with official mongo image:  
	```sh
	docker run --name mongodb -d -p 27017:27017 mongo:2
	```

4. Modify configuration(`server/config/environment/development.js`) to connect to mongodb container:  
	```js
	mongo: {
	  uri: 'mongodb://mongodb/workspace-dev'
	},
	```

5. Run `grunt:serve`, linking to mongodb container:  
	```sh
	docker run -it --name web -v $PWD:/workspace -p 9000:9000 --link mongodb royling/mean-dev grunt serve
	```

6. Open your browser and go to `http://localhost:9000`, start your work!  
	For MacOS/Windows users, use the ip of VM which docker runs on.
