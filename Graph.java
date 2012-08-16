import java.util.ArrayList;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Graph
{
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
		lock = new ReentrantLock();
		threads = new Thread[threadsNo];
		data = new int [size][size];
		weights = new int [size];
		visited = new boolean[size];
		path = new ArrayList<Integer>();
	}
	
	public void lock()
	{
		lock.lock();
	}
	
	public void unlock()
	{
		lock.unlock();
	}
	
	public void addEdge(int i, int j, int weight)
	{
		data[i][j] = data[j][i] = weight;
	}
	
	public void setWeight(int i, int weight)
	{
		weights[i] = weight;
	}
	
	public int getData(int i, int j)
	{
		return data[i][j];
	}
	
	public int getWeight(int i)
	{
		return weights[i];
	}
	
	public boolean isVisited(int i)
	{
		return visited[i];
	}
	
	private void calculateMinimums(int from, int to)
	{
		// All vertexes have starting infinity values of weights
		for (int i = 0; i < weights.length; ++i)
		{
			weights[i] = Dijkstra.INFINITY;
		}
		// Starting vertex has zero value
		weights[from] = 0;
		
		int current = from;
		while (current != to)
		{
			for (int i = 0; i < data[current].length; ++i)
			{
				// USING SEVERAL THREADS HERE
				calculateWeightsRunnable c = 
						new calculateWeightsRunnable(this, current, i);
				
				threads[i % threads.length] = new Thread(c);
				threads[i % threads.length].start();
			}
			visited[current] = true;
			
			// Finding next vertex with smallest weight
			int next = to;
			for (int i = 0; i < weights.length; ++i)
			{
				// But not zero & not visited yet
				if (weights[i] <  weights[next] && weights[i] != 0 && !visited[i])
				{
					next = i;
				}
			}
			
			current = next;
		}
	}
	
	public int [] findPath(int from, int to)
	{
		calculateMinimums(from, to);
		
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
			returnPath[i] = integerPath[returnPath.length - i - 1].intValue();
		}
		
		return returnPath;
	}
	
	// Lock
	private Lock lock;
	// Threads array
	Thread [] threads;
	// Contains information about edges
	private int [][] data;
	// Weights of vertexes
	private int [] weights;
	// What vertexes were visited
	private boolean [] visited;
	// Sequence of vertexes
	private ArrayList<Integer> path;
}
