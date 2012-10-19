

# This program decodes DNA sequences to Proteins
# There are several rules how DNA sequences should lool like
# And how they can be decoded
def main():

    data = ""
    while data != "q":
        data = raw_input("Input DNA sequence, or 'q' to quit: ")
        # we want work only with lower case letters
        data = data.lower()

        if data == 'q':
            continue

        # run all the checks
        # is length of data multiple of three?
        if not mult_of_three(data):
            continue
        # are all charecters valid?
        if not characters(data):
            continue
        # is start codon valid?
        if not start_codon(data):
            continue
        # is stop codon valid?
        if not stop_codon(data):
            continue

        print "Protein    ------->    ", decode_dna(data)


# Check all characters
# They can be only 'a', 'c', 't', 'g'
# Return False if not true
def characters(data):
    for letter in data:
        if letter not in "actg":
            print "Not DNA, illegal character"
            return False

    return True


# Check start codon
# It can be only "atg" codon
# And it can't be in mid sequence
def start_codon(data):
    start = "atg"
    if not data.startswith(start):
        print "Not DNA, no start codon"
        return False

    # split DNA on 3 letters sclices
    # and each can't be start codon
    for i in range(3, len(data) - 3, 3):
        if start == data[i: i + 3]:
            print "Not valid DNA, start codon in mid-sequence"
            return False

    return True


# So on with stop codon
# There are 3 stop codons
# "taa", "tga" and "tag"
def stop_codon(data):
    stop_codons = ["taa", "tga", "tag"]

    if data[-3:] not in stop_codons:
        print "Not DNA, no stop codon"
        return False

    for stop in stop_codons:
        # try to find it in data sequence
        for i in range(3, len(data) - 3, 3):
            if stop == data[i: i + 3]:
                print "Not valid DNA, stop codon in mid-sequence"
                return False

    return True


# Check number of characters in data
# It must be multiple of 3
def mult_of_three(data):
    if len(data) % 3 != 0:
        print "Not DNA, length not a multiple of 3"
        return False
    else:
        return True


# Decode DNA
# Get all data and apply get_dna for each triplet in it
def decode_dna(data):
    result = []

    for i in range(0, len(data) - 3, 3):
        # append result of get_dna function
        # it is one letter
        result.append(get_dna(data[i: i + 3]))

    return "".join(result).upper()


# Decode one triplet
# Return one letter
def get_dna(codon):
    # stop codons can't be used here
    # because if it is in mid-sequence
    # warning message would appear

    # phenylalanine
    if "ttt" in codon or "ttc" in codon:
        return 'f'
    # after that all that starts with "tt" or "ct" is leucine
    elif codon.startswith("tt") or codon.startswith("ct"):
        return 'l'

    # methionine
    elif "atg" in codon:
        return 'm'
    # now all started from "at" is isoleucine
    elif codon.startswith("at"):
        return 'i'

    # valine
    elif codon.startswith("gt"):
        return 'v'

    # serine
    elif codon.startswith("tc") or "agt" in codon or "agc" in codon:
        return 's'
    # now all started from "ag" is arginine
    elif codon.startswith("cg") or codon.startswith("ag"):
        return 'r'

    # proline
    elif codon.startswith("cc"):
        return 'p'
    # threonine
    elif codon.startswith("ac"):
        return 't'
    # alanine
    elif codon.startswith("gc"):
        return 'a'
    # this is not in order but also 2-letters
    # glycine
    elif codon.startswith("gg"):
        return 'g'

    # tyrosine
    elif codon.startswith("ta"):
        return 'y'

    # histidine
    elif "cat" in codon or "cac" in codon:
        return 'h'
    # now all with "ca" is glutamine
    elif codon.startswith("ca"):
        return 'q'

    # asparagine
    elif "aat" in codon or "aac" in codon:
        return 'n'
    # now lysine can be coded by 2-letters
    elif codon.startswith("aa"):
        return 'k'

    # aspartic acid
    elif "gat" in codon or "gac" in codon:
        return 'd'
    # glutamic acid
    elif codon.startswith("ga"):
        return 'e'

    # tryptophan
    elif "tgg" in codon:
        return 'w'
    # cysteine
    elif codon.startswith("tg"):
        return 'c'

if __name__ == "__main__":
    main()
