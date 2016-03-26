# Instant-runoff voting

Ballot counter for IRV in Racket.

USAGE:

	(read-votes-file "filename.csv")

CSV file format:

	Candidate 1,Candidate 2,Candidate 3,Candidate 4
    3,2,4,1
    1,2,3,4
    2,1,3
    4
    ...

The first line of the CSV holds the candidates' names. Each subsequent line is a ballot in order of preference (e.g. `2,1,3` is a ballot for Candidate 2, Candidate 1, and Candidate 3, in that order). A sample file is included in votes.csv.

