/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody"; //"nobody"

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization -- "black" */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#a31824",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;
