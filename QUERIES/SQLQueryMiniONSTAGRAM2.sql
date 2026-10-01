use master 
If DB_ID ('MiniInstagram') Is NULL 
	begin 
		Create DATABASE MiniInstagram 
		Print 'Database have created '
	End 
Else 
	begin 
	
	Drop DATABASE MiniInstagram
	Print 'database already exists '
	End 
GO

Use MiniInstagram
Go 

Create schema auths
GO 

Create table auths.Users
(
		id		INT PRIMARY KEY IDENTITY 	
		,username	NVARCHAR(50) NOT NULL
,CONSTRAINT CK_username_FORMAT CHECK (username NOT LIKE '%!%'
									AND username NOT LIKE '%#%'
									AND username NOT LIKE '%$%'
									AND username NOT LIKE '%*%')
		,email	NVARCHAR(50) NOT NULL UNIQUE
		,password	NVARCHAR(50) NOT NULL
,CONSTRAINT CK_password_FORMAT CHECK (LEN(password)>=12)
		,phoneNumber VARCHAR(11)
,CONSTRAINT UK_MOBILE UNIQUE (username,phoneNumber)
,CONSTRAINT CK_MOBILE_FORMAT CHECK (phoneNumber lIKE '09[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')-- برای خود شماره های موبایل 
		,firstN		NVARCHAR(50) NOT NULL
	
		,lastN		NVARCHAR(50) NOT NULL
		,birthday	DATE NOT NULL 
		,profileIMAGE NVARCHAR(50) NOT NULL 
		,bio		NVARCHAR(50) NOT NULL
		,createAt	DATETIME DEFAULT GETDATE() NOT NULL
 )
GO 

CREATE SCHEMA social 
GO 

CREATE TABLE social.FOLLOW 
(
	followerId		INT NOT NULL 
	,followingId	INT NOT NULL 
,CONSTRAINT PK_follow PRIMARY KEY (followerId,followingId)
,CONSTRAINT FK_followerId FOREIGN KEY (followerId) REFERENCES auths.[Users](id) 
,CONSTRAINT FK_followingId FOREIGN KEY (followingId) REFERENCES auths.[Users](id)
)
GO 

CREATE SCHEMA MEDIA 
GO 

CREATE TABLE MEDIA.media 
(	id INT PRIMARY KEY 
	,media_url NVARCHAR(70) NOT NULL
	,media_type NVARCHAR (50) NOT NULL 
)

CREATE TABLE social.posts
(	
	ID			INT PRIMARY KEY IDENTITY 
	,[user_id]	INT NOT NULL
	,media_id	INT NOT NULL
	,caption	NTEXT
	,createdAt DATETIME DEFAULT GETDATE() NOT NULL 
,CONSTRAINT FK_POST_user FOREIGN KEY ([user_id]) REFERENCES auths.[Users](id)
,CONSTRAINT FK_POST_media FOREIGN KEY ([media_id]) REFERENCES MEDIA.media(id)
)
GO 

CREATE TABLE social.story
(
	id		INT PRIMARY KEY IDENTITY
	,[user_id]		INT NOT NULL 
	,media			INT NOT NULL
	,created		DATETIME DEFAULT GETDATE() NOT NULL 
	,expired		DATETIME 
,CONSTRAINT FK_STORY_user FOREIGN KEY ([user_id]) REFERENCES auths.[Users](id)
,CONSTRAINT FK_STORY_media FOREIGN KEY ([media]) REFERENCES MEDIA.media(id)
)
GO 

CREATE TABLE social.storyViews 
(
	story_id	INT NOT NULL
	,viewer_id	INT NOT NULL
,CONSTRAINT	FK_StoryView_Story	FOREIGN KEY (story_id)	REFERENCES	social.story(id)
,CONSTRAINT	FK_StoryView_User	FOREIGN KEY (viewer_id)	REFERENCES	auths.[Users](id)
ON	Delete	CASCADE 
,CONSTRAINT PK_StoryView PRIMARY KEY (story_id, viewer_id)

)
Go

CREATE TABLE social.saves
(
	id		INT NOT NULL 
	,media	INT NOT NULL 
	,created  DATETIME DEFAULT GETDATE() NOT NULL 
,CONSTRAINT FK_saves_user FOREIGN KEY ([id]) REFERENCES auths.[Users](id)
,CONSTRAINT FK_saves_media foreign KEY ([media]) REFERENCES MEDIA.media(id)
ON DELETE CASCADE
)
GO 

CREATE TABLE social.likes
(
	id		INT PRIMARY KEY IDENTITY(1,1)
	,[user_id] INT NOT NULL 
	,media		INT NOT NULL 
,CONSTRAINT UK_user_post UNIQUE ([user_id],media)
,constraint FK_user foreign KEY ([user_id]) REFERENCES auths.[Users](id)
,CONSTRAINT FK_post FOREIGN KEY ([media]) REFERENCES MEDIA.media(id)

)
GO 

CREATE TABLE social.comments 
(
	id				 INT PRIMARY KEY IDENTITY (1,1)
	,[user_id]		 INT not NULL 
	, [user_id2]	 INT NOT NULL 
	, caption		 NTEXT
,CONSTRAINT FK_comment_user FOREIGN KEY ([user_id])  REFERENCES auths.[Users](id)
,CONSTRAINT FK_COMMENTER_user FOREIGN KEY ([user_id2]) REFERENCES auths.[Users](id)
)
GO 

CREATE SCHEMA commerce
GO 

CREATE TABLE commerce.chat 
(
	sender_id	INT  PRIMARY KEY NOT NULL
	,reciver_id INT NOT NULL 
	,texts		INT IDENTITY  (1,1) 
	,sendAt		DATETIME DEFAULT GETDATE()
	,file_url	VARCHAR(500)
,CONSTRAINT FK_sender FOREIGN KEY ([sender_id]) REFERENCES auths.[Users](id)
,constraint FK_reciver FOREIGN KEY ([reciver_id]) REFERENCES auths.[Users](id)
)
GO 

CREATE TABLE commerce.chatMembers 
(
	id	INT PRIMARY KEY 
,CONSTRAINT FK_users FOREIGN KEY ([id]) REFERENCES auths.[Users](id)
)

CREATE TABLE commerce.videoCall 
(
	id  INT IDENTITY (1,1) PRIMARY KEY
	,callerID	INT 
	,reciverid	INT 
	,startTime	DATETIME
	,ENDtime DATETIME 
	,Statuss VARCHAR(20)
,CONSTRAINT FK_CALL_ID FOREIGN KEY (callerID) REFERENCES auths.[Users](id)
,CONSTRAINT FK_CALL_reciver FOREIGN KEY (reciverID) REFERENCES auths.[Users](id)
)
PRINT 'All Tables created successfuly'