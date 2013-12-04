import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.Random;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class Graph
{
	// ======= CONSTRUCTORS =======
	public Graph()
	{
		this(Dijkstra.THREADS_NO, Dijkstra.GRAPH_SIZE);
	}
	public Graph(int threadsNo)
	{
		this(threadsNo, Dijkstra.GRAPH_SIZE);
	}
	public Graph(int threadsNo, int size)
	{
		this.threadsNo = threadsNo;
		this.pool = Executors.newFixedThreadPool(threadsNo);

		data = new int [size][size];
		weights = new int [size];
		visited = new boolean[size];
	}

	// Method is called from fillThread.run()
	public synchronized void addEdge(int i, int j, int weight)
	{
		data[i][j] = data[j][i] = weight;
	}

	// Filling graph
	public void fill(int seed)
	{
		Random random = new Random(seed);
		Future<?> []results = new Future<?> [threadsNo];

		for (int thread = 0; thread < threadsNo; ++thread)
		{
			// Create task for all threads
			results[thread] = pool.submit(new Thread(new fillThread(this, random, thread)));
		}

		for (Future<?> result : results)
		{
			try
			{
				result.get();
			} catch (Exception e)
			{
				e.printStackTrace();
			}
		}

		System.out.println("Graph filled.");
	}

	private void calculateMinimums(int from, int to)
	{
		// All vertexes have starting infinity values of weights
		Arrays.fill(weights, Dijkstra.INFINITY);

		// Starting vertex has zero value
		weights[from] = 0;

		int current = from;
		while (current != to)
		{
			LinkedList<Future<Edge>> results = new LinkedList<Future<Edge>>();
			for (int i = 0; i < data[current].length; ++i)
			{
				// Creating new tasks
				Future<Edge> f = pool.submit(new calculateThread(this, current, i));
				results.add(f);
			}
			visited[current] = true;

			// Get results and find minimum
			int next = to;
			for (Future<Edge> result : results)
			{
				try
				{
					Edge edge = result.get();
					int weight = edge.getWeight();

					synchronized(this)
					{
						// Calculate minimum
						if (weight != 0 && weight < weights[next])
							next = edge.getVertex();
					}
				} catch (Exception e)
				{
					e.printStackTrace();
				}

			}
			current = next;
		}
		System.out.println("Calculated minimums of graph.");
	}

	public int [] findPath(int from, int to)
	{
		calculateMinimums(from, to);

		ArrayList<Integer> path = new ArrayList<Integer>();
		int prev = to;
		// Going from last to first
		while (prev != from)
		{
			path.add(prev);
			for (int i = 0; i < weights.length; ++i)
			{
				// Finding previous
				if (data[i][prev] != 0 && weights[i] + data[i][prev] == weights[prev])
				{
					prev = i;
					break;
				}
			}
		}
		path.add(from);

		// Reversing order of vertexes & casting to array of ints
		Integer[] integerPath = path.toArray(new Integer[path.size()]);
		int [] returnPath = new int [path.size()];
		for (int i = 0; i < returnPath.length; ++i)
		{
			returnPath[i] = integerPath[returnPath.length - i - 1];
		}

		pool.shutdown();
		System.out.println("Found shortest path.");
		return returnPath;
	}

	// Threads number
	private int threadsNo;
	// Pool of threads
	private ExecutorService pool;
	// Contains information about edges
	private int [][] data;
	// Weights of vertexes
	private int [] weights;
	// What vertexes were visited
	private boolean [] visited;

	// ======= CLASS FILLTHREAD =======
	private class fillThread implements Runnable
	{
		public fillThread(Graph g, Random random, int thread)
		{
			this.outer = g;
			this.random = random;
			this.thread = thread;
		}

		public void run()
		{
			int workPerThread = Dijkstra.GRAPH_SIZE / Dijkstra.THREADS_NO;

			for (int i = thread * workPerThread;
					i < (thread + 1) * workPerThread; ++i)
			{
				for (int j = 0; j < Dijkstra.GRAPH_SIZE / 3; ++j)
				{
					outer.addEdge(i, random.nextInt(Dijkstra.GRAPH_SIZE),
							random.nextInt(Dijkstra.INFINITY));
					//System.out.println("Adding edge. Thread " + thread);
				}
			}
		}

		// ======= PRIVATE =======
		private Graph outer;
		private Random random;
		private int thread;
	}

	// ======= CLASS CALCULATETHREAD =======
	private class calculateThread implements Callable<Edge>
	{
		public calculateThread(Graph graph, int current, int i)
		{
			this.outer = graph;
			this.current = current;
			this.i = i;
		}

		public Edge call()
		{
			synchronized(outer)
			{
				int newWeight = 0;
				// If are connected
				if (outer.data[current][i] != 0 && !outer.visited[i])
				{
					newWeight = outer.weights[current] +
							outer.data[current][i];

					newWeight = newWeight < outer.weights[i] ?
							newWeight : outer.weights[i];
					outer.weights[i] = newWeight;
				}

				return new Edge(i, newWeight);
			}
		}

		// ======= PRIVATE =======
		private Graph outer;
		private int current;
		private int i;
	}

	// ======= CLASS EDGE =======
		private class Edge
		{
			public Edge(int vertex, int weight)
			{
				this.vertex = vertex;
				this.weight = weight;
			}

			public int getVertex() {return vertex;}
			public int getWeight() {return weight;}

			private int vertex;
			private int weight;
		}
}
